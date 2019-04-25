From: pavel@denx.de (Pavel Machek)
Date: Thu, 25 Apr 2019 10:40:14 +0200
Subject: [cip-dev] [PATCH 4.19.y 13/17] usb: gadget: udc: renesas_usb3:
 add a safety connection way for forced_b_device
In-Reply-To: <1556126440-27978-14-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1556126440-27978-14-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190425084014.GD32008@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> commit ceb94bc52c437463f0903e61060a94a2226fb672 upstream.
> 
> This patch adds a safety connection way for "forced_b_device" with
> "workaround_for_vbus" like below:

I don't understand what "safety connection way" is.

> @@ -2432,7 +2433,11 @@ static ssize_t renesas_usb3_b_device_write(struct file *file,
>  	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
>  		return -EFAULT;
>  
> -	if (!strncmp(buf, "1", 1))
> +	usb3->start_to_connect = false;
> +	if (usb3->workaround_for_vbus && usb3->forced_b_device &&
> +	    !strncmp(buf, "2", 1))
> +		usb3->start_to_connect = true;
> +	else if (!strncmp(buf, "1", 1))
>  		usb3->forced_b_device = true;
>  	else
>  		usb3->forced_b_device = false;

I don't think this is correct. If user writes "12" to the file,
(!strncmp(buf, "1", 1)) will still be true, AFAICT. Similar problem
exists elsewhere in the file, with (!strncmp(buf, "host",
strlen("host"))).

This is adding new option to kernel interface. ("2" to sysfs file). I
believe that should be documented in Documentation/ABI.

Anyway, I'll most likely apply the patch, as problem needs to be fixed
in the mainline, first.

Best regards,
								Pavel

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190425/1670d415/attachment.sig>
