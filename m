From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Thu, 25 Apr 2019 14:28:16 +0100
Subject: [cip-dev] [PATCH 4.4.y V2] DHCP client support when receiving
	"delayed" replies
Message-ID: <1556198897-5710-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

This is the squashed series of patches to fix the DHCP client issue in 4.4.y.
The issue arises when a DHCP server takes longer than 1s to reply to the DHCP
client in the kernel, and the kernel has multiple networking interfaces enabled.

Thanks,
Patryk


Uwe Kleine-K?nig (1):
  net: ipconfig: Support using "delayed" DHCP replies

 net/ipv4/ipconfig.c | 61 ++++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

-- 
2.7.4
