From: pavel@denx.de (Pavel Machek)
Date: Sun, 14 Jul 2019 23:46:06 +0200
Subject: [cip-dev] Regarding backporting RTC PCF85263 driver to cip 4.4
 kernel
In-Reply-To: <OSBPR01MB210389D3E16B7A69C24ADF0EB8F20@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <OSBPR01MB210389D3E16B7A69C24ADF0EB8F20@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20190714214606.GA19428@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!
> 
> RTC PCF85263 is used by iWave RZ/G1C SBC( iwg23s) platform.  We have upstreamed  this driver support  on 4.19 kernel [1]
> [1]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/rtc-pcf85363.c?h=v5.2&id=fc979933bcf162595b6004d0de4effb64c323152
> 
> This driver is based  on RTC PCF 85363 driver which has rtc nvmem/alarm support [2] .  Rtc nvmem framework is introduced in 4.13
> [2]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/rtc-pcf85363.c?h=v5.2&id=a9687aa2764dd2669602bd19dc636cbeef5293d5
> 
> We are seeing the following options for backporting this driver to
> 4.4 kernel

First, you did a lot of work there...

> Option 1:
> Backport this driver[1] to 4.4 kernel along with nvmem/alarm support. we have already done this work and patches are available at [3]
> [3]. https://gitlab.com/bijud/pcf85263/tree/master

Ok, this is rather long/big series, and some parts are quite scary:
https://gitlab.com/bijud/pcf85263/blob/master/0013-rtc-nvmem-allow-registering-the-nvmem-device-before-.patch

> Option 2:
> Backport RTC PCF85263 driver, removing  Alarm/nvmem functionality
> from  [2] .

So we basically get this one, and few patches on top, local to the new files.
https://gitlab.com/bijud/pcf85263/blob/master/0015-rtc-add-support-for-NXP-PCF85363-real-time-clock.patch

I think I prefer option 2. 

> Option 3:
> Don't backport RTC support at all.

Applying patch #15 is easy. We can do option 2 I believe.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190714/47a6b486/attachment.sig>
