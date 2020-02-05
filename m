From: pavel@denx.de (Pavel Machek)
Date: Wed, 5 Feb 2020 23:37:38 +0100
Subject: [cip-dev] [PATCH 4.4 00/53] 4.4.213-stable review
In-Reply-To: <20200205130207.GA1199959@kroah.com>
References: <20200203161902.714326084@linuxfoundation.org>
 <TYAPR01MB2285D96DC944217E7A22F8C6B7030@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20200205130207.GA1199959@kroah.com>
Message-ID: <20200205223738.GC1140@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed 2020-02-05 13:02:07, Greg Kroah-Hartman wrote:
> On Tue, Feb 04, 2020 at 09:50:56AM +0000, Chris Paterson wrote:
> > Hi Greg,
> > 
> > > From: stable-owner at vger.kernel.org <stable-owner@vger.kernel.org> On
> > > Behalf Of Greg Kroah-Hartman
> > > Sent: 03 February 2020 16:19
> > > 
> > > This is the start of the stable review cycle for the 4.4.213 release.
> > > There are 53 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> > > Anything received after that time might be too late.
> > 
> > We're seeing an issue with 4.4.213-rc1 (36670370c48b) and 4.4.213-rc2 (758a39807529) with our 4 am335x configurations [0]:
> > 
> >    AS      arch/arm/kernel/hyp-stub.o
> >  arch/arm/kernel/hyp-stub.S:   CC      arch/arm/mach-omap2/sram.o
> >  Assembler messages:
> >    AS      arch/arm/kernel/smccc-call.o
> >  arch/arm/kernel/hyp-stub.S:147: Error: selected processor does not support `ubfx r7,r7,#16,#4' in ARM mode
> >  scripts/Makefile.build:375: recipe for target 'arch/arm/kernel/hyp-stub.o' failed
> >  make[1]: *** [arch/arm/kernel/hyp-stub.o] Error 1
> > 
> > The culprit seems to be: 15163bcee7b5 ("ARM: 8955/1: virt: Relax arch timer version check during early boot")
> > Reverting the same resolves the build issue.
> > 
> > Latest pipeline: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/pipelines/114683657
> > 
> > [0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/4.4.y-cip/arm/
> > siemens_am335x-axm2_defconfig, siemens_am335x-draco_defconfig, siemens_am335x-dxr2_defconfig, siemens_am335x-etamin_defconfig
> 
> Thanks, I'll go drop that patch from 4.4 and 4.9 trees.

I believe it is more likely than not to break 4.19 (and possibly
mainline), too, but I have not yet done required testing.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200205/bae3be3c/attachment.sig>
