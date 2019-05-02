From: pavel@denx.de (Pavel Machek)
Date: Thu, 2 May 2019 23:19:29 +0200
Subject: [cip-dev] [PATCH 4.4.y V2] net: ipconfig: Support using
 "delayed" DHCP replies
In-Reply-To: <1556198897-5710-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
References: <1556198897-5710-1-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
	<1556198897-5710-2-git-send-email-patryk.mungai-ndungu.kx@renesas.com>
Message-ID: <20190502211929.GA19728@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> The dhcp code only waits 1s between sending DHCP requests on different
> devices and only accepts an answer for the device that sent out the last
> request. Only the timeout at the end of a loop is increased iteratively
> which favours only the last device. This makes it impossible to work
> with a dhcp server that takes little more than 1s connected to a device
> that is not the last one.
> 
> Instead of also increasing the inter-device timeout, teach the code to
> handle delayed replies.
> 
> To accomplish that, make *ic_dev track the current ic_device instead of
> the current net_device and adapt all users accordingly. The relevant
> change then is to reset d to ic_dev on a reply to assert that the
> followup request goes through the right device.

Thanks!

In the end I decided to apply this one. It is true that the alternate
fix is one-liner, but I would not be sure if other timing parameters
need changing, and would not have a good way to test that.

Best regards,
								Pavel

> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -94,7 +94,6 @@
>  /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
>  #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
>  #define CONF_SEND_RETRIES 	6	/* Send six requests per open */
> -#define CONF_INTER_TIMEOUT	(HZ)	/* Inter-device timeout: 1 second */
>  #define CONF_BASE_TIMEOUT	(HZ*2)	/* Initial timeout: 2 seconds */
>  #define CONF_TIMEOUT_RANDOM	(HZ)	/* Maximum amount of randomization */
>  #define CONF_TIMEOUT_MULT	*7/4	/* Rate of timeout growth */

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190502/acebc038/attachment.sig>
