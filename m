From: pavel@denx.de (Pavel Machek)
Date: Tue, 4 Feb 2020 13:47:21 +0100
Subject: [cip-dev] [PATCH 4.4 00/53] 4.4.213-stable review
In-Reply-To: <TYAPR01MB2285D96DC944217E7A22F8C6B7030@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <20200203161902.714326084@linuxfoundation.org>
 <TYAPR01MB2285D96DC944217E7A22F8C6B7030@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20200204124721.GB6903@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > From: stable-owner at vger.kernel.org <stable-owner@vger.kernel.org> On
> > Behalf Of Greg Kroah-Hartman
> > Sent: 03 February 2020 16:19
> > 
> > This is the start of the stable review cycle for the 4.4.213 release.
> > There are 53 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> > Anything received after that time might be too late.
> 
> We're seeing an issue with 4.4.213-rc1 (36670370c48b) and 4.4.213-rc2 (758a39807529) with our 4 am335x configurations [0]:
> 
>    AS      arch/arm/kernel/hyp-stub.o
>  arch/arm/kernel/hyp-stub.S:   CC      arch/arm/mach-omap2/sram.o
>  Assembler messages:
>    AS      arch/arm/kernel/smccc-call.o
>  arch/arm/kernel/hyp-stub.S:147: Error: selected processor does not support `ubfx r7,r7,#16,#4' in ARM mode
>  scripts/Makefile.build:375: recipe for target 'arch/arm/kernel/hyp-stub.o' failed
>  make[1]: *** [arch/arm/kernel/hyp-stub.o] Error 1
> 
> The culprit seems to be: 15163bcee7b5 ("ARM: 8955/1: virt: Relax arch timer version check during early boot")
> Reverting the same resolves the build issue.
> 
> Latest pipeline: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/pipelines/114683657
> 
> [0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/4.4.y-cip/arm/
> siemens_am335x-axm2_defconfig, siemens_am335x-draco_defconfig, siemens_am335x-dxr2_defconfig, siemens_am335x-etamin_defconfig
> 

For the record, build results are here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/pipelines/114683657

4.19.102 builds okay:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/pipelines/114683672

but that's probably because siemens_am335x* configurations are not
tested in 4.19.X case.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200204/9be50b0a/attachment.sig>
