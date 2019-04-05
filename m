From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Fri,  5 Apr 2019 11:47:31 +0100
Subject: [cip-dev] [PATCH 4.4 0/5] DHCP client support when receiving
	"delayed" replies
Message-ID: <1554461256-12966-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

When running dhcp tests using the 4.4.y (and 4.4.y-cip kernel as well), I
encountered an issue where the dhcp client in the kernel could not get an
IP address when multiple network devices were enabled. It seems that the
current implementation of the dhcp client in the 4.4 kernel is send dhcp
request via device 1 -> wait <1s for response from server on device 1 ->
if no response, switch to device 2 -> repeat process on device 2 ...etc.
When the dhcp server is slow to respond, this means it is impossible to get
a dhcp address.

This series backported from upstream fixes the issue, is it possible
to apply this to 4.4.y and/or 4.4.y-cip?

Thanks,
Patryk


Geert Uytterhoeven (1):
  net: ipconfig: Fix NULL pointer dereference on RARP/BOOTP/DHCP timeout

Thierry Reding (1):
  net: ipconfig: Fix more use after free

Uwe Kleine-K?nig (3):
  net: ipconfig: Support using "delayed" DHCP replies
  net: ipconfig: drop inter-device timeout
  net: ipconfig: fix use after free

 net/ipv4/ipconfig.c | 61 ++++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

-- 
2.7.4
