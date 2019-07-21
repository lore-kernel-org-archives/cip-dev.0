From: pavel@denx.de (Pavel Machek)
Date: Sun, 21 Jul 2019 18:25:59 +0200
Subject: [cip-dev] Request for guidance: removal of old config files
 [was: Kernel configurations for 4.19?]
In-Reply-To: <fae9b423882c15f5e31eaef237086f38055dcfce.camel@codethink.co.uk>
References: <1555501985.3557.26.camel@codethink.co.uk>
	<9210b0ba912e7a8c64f6562b43f25e4763ac4379.camel@codethink.co.uk>
	<7c8d175eaa43357d6484c6fee89c4d0f@codethink.co.uk>
	<909b4353-87c9-08e2-46f1-4ef8ce3fb6d2@siemens.com>
	<fae9b423882c15f5e31eaef237086f38055dcfce.camel@codethink.co.uk>
Message-ID: <20190721162559.GB10770@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Fri 2019-07-12 17:34:47, Ben Hutchings wrote:
> On Thu, 2019-07-11 at 18:51 +0200, Jan Kiszka wrote:
> [...]
> > > 4.19/arm/hitachi_omap_defconfig
> > > 4.19/arm/moxa_mxc_defconfig
> > > 4.19/arm/siemens_am335x-axm2_defconfig
> > > 4.19/arm/siemens_am335x-draco_defconfig
> > > 4.19/arm/siemens_am335x-dxr2_defconfig
> > > 4.19/arm/siemens_am335x-etamin_defconfig
> > > 4.19/arm/siemens_am57xx-pxm3_defconfig
> > 
> > Those can go, I'm not aware of their usage on 4.19. But do we have one for the
> > am335-x-based BBB, our reference board?
> 
> Good point.  I have not yet tried running 4.19 on the BBB, but I can
> look at adding one - or perhaps Nobuhiro or Pavel already has a
> suitable config?

No easy access to BBB here, sorry.

I have added directory 4.19-rt and added config for socfpga I'd like
to be used for testing in Lava lab. It is not configuration that needs
to be officially supported with CIP project.

I hope that is okay.

If someone uses rt on some other hardware, I'd like to know.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190721/d06d99d0/attachment.sig>
