From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Wed, 5 Jun 2019 08:27:59 +0000
Subject: [cip-dev] porting iwg20m to isar-cip-core
In-Reply-To: <d0acd9f6-2f30-2407-c202-5600b3750352@siemens.com>
References: <20190605021645.4464-1-daniel.sangorrin@toshiba.co.jp>
	<d0acd9f6-2f30-2407-c202-5600b3750352@siemens.com>
Message-ID: <TY2PR01MB33231DCBB1664127B91D0673D0160@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

> From: isar-users at googlegroups.com <isar-users@googlegroups.com> On Behalf Of Jan Kiszka
> On 05.06.19 04:16, Daniel Sangorrin wrote:
> > I wanted to use uImage because that's what is used in the
> > iwg20m manual, and it's known to work on Deby as well.
> > Ref:
> https://gitlab.com/cip-project/cip-core/deby/blob/master/poky/meta-cip-iwg20m/README.IWG20M.txt
> > Do you suggest that we should use bootz instead of bootm?
> > Is uImage not recommended or something? I have used uImage in many boards.
> 
> BTW, we chose bootz (and distro boot) in order to be able to boot also stock
> Debian kernels - which work on a (slowly) increasing number of boards. I.e. Isar
> is modeled around the ideal case, not legacy ones.

I was surprised to see so many u-boot debian packages:
https://packages.debian.org/search?keywords=u-boot

For now, please let me go the legacy way (ask users to 'setenv' things). Do you have an example of how to emulate boot.scr on older u-boot versions. I

Iwamatsu-san is going to upgrade/mainstream the u-boot support for Renesas iwg20m. Once that is done I will modify the recipe.
# One thing though: if the flash process fails, you really need to get a JTAG device to unbrick the board (not sure if OpenOCD JTAG devices would be supported).

Thanks,
Daniel

> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
> 
> --
> You received this message because you are subscribed to the Google Groups "isar-users" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to
> isar-users+unsubscribe at googlegroups.com.
> To post to this group, send email to isar-users at googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/isar-users/d0acd9f6-2f30-2407-c202-5600b3750352%40siemens.com.
> For more options, visit https://groups.google.com/d/optout.
