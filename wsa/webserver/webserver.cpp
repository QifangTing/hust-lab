// webserver.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include <stdio.h>
#include <winsock2.h>)
#include <list>
#include <algorithm>
#include <string.h>

#define MAXCONN 5
#define BUFLEN 255
#define SERVER_PORT 80

using namespace std;

typedef list<SOCKET> ListCONN;
typedef list<SOCKET> ListConErr;

int main(int argc, char **argv) {
	WSADATA wsaData;
	int nRC;

	sockaddr_in srvAddr;
	sockaddr_in clientAddr;
	SOCKET srvSock;

	int nAddrLen = sizeof(sockaddr);

	char sendBuf[BUFLEN];
	char recvBuf[BUFLEN];

	ListCONN conList;		// ����������Ч�ĻỰSOCKET
	ListCONN::iterator itor;
	ListConErr conErrList;	// ��������ʧЧ�ĻỰSOCKET
	ListConErr::iterator itor1;

	FD_SET rfds;
	FD_SET wfds;
	u_long uNonBlock;

	// ��ʼ�� winsock
	nRC = WSAStartup(0x0101, &wsaData);
	if (nRC) {
		printf("Server initialize winsock error!\n");
		return -1;
	}

	if (wsaData.wVersion != 0x0101) {
		printf("Server's winsock version error!\n");
		WSACleanup();
		return -1;
	}

	printf("Server's winsock initialized !\n");

	// ���� TCP socket
	srvSock = socket(AF_INET, SOCK_STREAM, 0);
	if (srvSock == INVALID_SOCKET) {
		printf("Server create socket error!\n");
		WSACleanup();
		return -1;
	}

	printf("Server TCP socket create OK!\n");

	// �� socket to Server's IP and port 80
	srvAddr.sin_family = AF_INET;
	srvAddr.sin_port = htons(SERVER_PORT);
	srvAddr.sin_addr.S_un.S_addr = INADDR_ANY;
	nRC = bind(srvSock, (LPSOCKADDR)&srvAddr, sizeof(srvAddr));
	if (nRC == SOCKET_ERROR) {
		printf("Server socket bind error!\n");
		closesocket(srvSock);
		WSACleanup();
		return -1;
	}
	printf("Server socket bind OK!\n");

	// ��ʼ�������̣��ȴ��ͻ�������
	nRC = listen(srvSock, MAXCONN);
	if (nRC == SOCKET_ERROR) {
		printf("Server socket listen error!\n");
		closesocket(srvSock);
		WSACleanup();
		return -1;
	}

	printf("Start to listen for http request!\n");

	// ��srvSock��Ϊ������ģʽ�Լ����ͻ���������
	uNonBlock = 1;
	ioctlsocket(srvSock, FIONBIO, &uNonBlock);

	while (true) {
		// ��conList��ɾ���Ѿ���������ĻỰSOCKET
		for (itor1 = conErrList.begin(); itor1 != conErrList.end(); itor1++) {
			itor = find(conList.begin(), conList.end(), *itor1);
			if (itor != conList.end()) conList.erase(itor);
		}

		// ���read, write�׽��ּ���
		FD_ZERO(&rfds);
		FD_ZERO(&wfds);

		// ���õȴ��ͻ���������
		FD_SET(srvSock, &rfds);

		for (itor = conList.begin(); itor != conList.end(); itor++) {
			// �����лỰSOCKET��Ϊ������ģʽ
			uNonBlock = 1;
			ioctlsocket(*itor, FIONBIO, &uNonBlock);
			// ���õȴ��ỰSOKCET�ɽ������ݻ�ɷ�������
			FD_SET(*itor, &rfds);
			FD_SET(*itor, &wfds);
		}

		// ��ʼ�ȴ�
		int nTotal = select(0, &rfds, &wfds, NULL, NULL);

		// ���srvSock�յ��������󣬽��ܿͻ���������
		if (FD_ISSET(srvSock, &rfds)) {
			nTotal--;
			// �����ỰSOCKET
			SOCKET connSock = accept(srvSock, (LPSOCKADDR)&clientAddr, &nAddrLen);
			if (connSock == INVALID_SOCKET) {
				printf("Server accept connection request error!\n");
				closesocket(srvSock);
				WSACleanup();
				return -1;
			}

			sprintf(sendBuf, "����%s���οͽ���������!\n", inet_ntoa(clientAddr.sin_addr));
			printf("%s", sendBuf);

			// �������ĻỰSOCKET������conList��
			conList.insert(conList.end(), connSock);
		}
		
		if (nTotal > 0) {
			// ���������Ч�ĻỰSOCKET�Ƿ������ݵ���
			// ���Ƿ���Է�������
			for (itor = conList.begin(); itor != conList.end(); itor++) {
				// ����ỰSOCKET���Է������ݣ�
				// ����ͻ�������Ϣ
				if (FD_ISSET(*itor, &wfds)) {
					// ������ͻ����������ݣ�����
					if (strlen(sendBuf) > 0) {
						nRC = send(*itor, sendBuf, strlen(sendBuf), 0);
						if (nRC == SOCKET_ERROR) {
							// �������ݴ���
							// ��¼�²�������ĻỰSOCKET
							conErrList.insert(conErrList.end(), *itor);
						}
						else {
							// �������ݳɹ�����շ��ͻ�����
							memset(sendBuf, '\0', BUFLEN);
						}
					}
				}

				// ����ỰSOCKET�����ݵ���������ܿͻ�������
				if (FD_ISSET(*itor, &rfds)) {
					nRC = recv(*itor, recvBuf, BUFLEN, 0);
					if (nRC == SOCKET_ERROR) {
						// �������ݴ���
						// ��¼�²�������ĻỰSOCKET
						conErrList.insert(conErrList.end(), *itor);
					} else {
						// �������ݳɹ��������ڷ��ͻ������У�
						// �Է��͵����пͻ�ȥ
						recvBuf[nRC] = '\0';
						sprintf(sendBuf, "\n�ο�˵:%s\n", recvBuf);
						printf("%s", sendBuf);
					}
				}
			}
		}
	}

	closesocket(srvSock);
	WSACleanup();

	return 0;
}

