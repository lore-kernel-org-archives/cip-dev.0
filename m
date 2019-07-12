From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 12 Jul 2019 11:28:35 +0000
Subject: [cip-dev] Regarding backporting RTC PCF85263 driver to cip 4.4
	kernel
Message-ID: <OSBPR01MB210389D3E16B7A69C24ADF0EB8F20@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi All,

RTC PCF85263 is used by iWave RZ/G1C SBC( iwg23s) platform.  We have upstreamed  this driver support  on 4.19 kernel [1]
[1]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/rtc-pcf85363.c?h=v5.2&id=fc979933bcf162595b6004d0de4effb64c323152

This driver is based  on RTC PCF 85363 driver which has rtc nvmem/alarm support [2] .  Rtc nvmem framework is introduced in 4.13
[2]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/rtc-pcf85363.c?h=v5.2&id=a9687aa2764dd2669602bd19dc636cbeef5293d5

We are seeing the following options for backporting this driver to 4.4 kernel

Option 1:
Backport this driver[1] to 4.4 kernel along with nvmem/alarm support. we have already done this work and patches are available at [3]
[3]. https://gitlab.com/bijud/pcf85263/tree/master

Option 2:
Backport RTC PCF85263 driver, removing  Alarm/nvmem functionality from  [2] .

Option 3:
Don't backport RTC support at all.

Please share your views, so that I can work on this accordingly.

Regards,
Biju


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190712/f0a5459e/attachment.html>
