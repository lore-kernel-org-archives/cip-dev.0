From: pavel@denx.de (Pavel Machek)
Date: Wed, 17 Jul 2019 13:29:53 +0200
Subject: [cip-dev] [PATCH 4.4.y-cip 01/10] rtc: add support for NXP
 PCF85363 real-time clock
In-Reply-To: <1563264921-42973-2-git-send-email-biju.das@bp.renesas.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
	<1563264921-42973-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190717112953.GA8507@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue 2019-07-16 09:15:12, Biju Das wrote:
> From: Eric Nelson <eric@nelint.com>
> 
> commit a9687aa2764dd2669602bd19dc636cbeef5293d5 upstream.
> 
> Note that alarms are not currently implemented.
> 
> 64 bytes of nvmem is supported and exposed in
> sysfs (# is the instance number, starting with 0):
> 
> 	/sys/bus/nvmem/devices/pcf85363-#/nvmem
>


Just FYI, git does not like your whitespace:

Applying: rtc: add support for NXP PCF85363 real-time clock
/data/pavel/cip/k/.git/rebase-apply/patch:32: new blank line at EOF.
+

Best regards,
							Pavel

>  Documentation/devicetree/bindings/rtc/pcf85363.txt |  17 ++
>  drivers/rtc/Kconfig                                |   9 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-pcf85363.c                         | 197 +++++++++++++++++++++
>  4 files changed, 224 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
>  create mode 100644 drivers/rtc/rtc-pcf85363.c
> 
> diff --git a/Documentation/devicetree/bindings/rtc/pcf85363.txt b/Documentation/devicetree/bindings/rtc/pcf85363.txt
> new file mode 100644
> index 0000000..76fdabc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/pcf85363.txt
> @@ -0,0 +1,17 @@
> +NXP PCF85363 Real Time Clock
> +============================
> +
> +Required properties:
> +- compatible: Should contain "nxp,pcf85363".
> +- reg: I2C address for chip.
> +
> +Optional properties:
> +- interrupts: IRQ line for the RTC (not implemented).
> +
> +Example:
> +
> +pcf85363: pcf85363 at 51 {
> +	compatible = "nxp,pcf85363";
> +	reg = <0x51>;
> +};
> +

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190717/af0c24f1/attachment.sig>
