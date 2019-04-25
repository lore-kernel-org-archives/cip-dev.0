From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai)
Date: Thu, 25 Apr 2019 14:23:10 +0100
Subject: [cip-dev] [PATCH 4.4.y] Increase the inter-device timeout in the
	kernel's DHCP client
Message-ID: <1556198591-5414-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

This is a simple patch that increases the time a device is listening for a DHCP
response in the 4.4.y kernel.

In my use case, the DHCP server sometimes takes ~1.1s to send a DHCP response,
which results in the device unable to receive a DHCP address when multiple
networking devices are enabled. Increasing the timeout will increase the
likelihood of receiving a response from the server within the timeout period.

Please note that this patch is being submitted as an alternative to the patch:
net: ipconfig: Support using "delayed" DHCP replies
and it's relevant patch series.

Thanks,
Patryk

Patryk Mungai (1):
  Increase DHCP inter-device timeout

 net/ipv4/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4
