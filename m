From: pavel@denx.de (Pavel Machek)
Date: Thu, 11 Jul 2019 12:58:42 +0200
Subject: [cip-dev] [PATCH v3 4.4.y-cip] Add gitlab-ci.yaml
In-Reply-To: <20190708131603.17134-1-chris.paterson2@renesas.com>
References: <20190702105133.23765-1-chris.paterson2@renesas.com>
	<20190708131603.17134-1-chris.paterson2@renesas.com>
Message-ID: <20190711105842.GB7605@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon 2019-07-08 14:16:03, Chris Paterson wrote:
> This is configured to build and test the following configurations:
> 
> * BUILD_ARCH: arm
> * CONFIG: renesas_shmobile_defconfig
> * CONFIG_LOC: cip-kernel-config
> * DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
> * DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
> 
> * BUILD_ARCH: arm
> * CONFIG: shmobile_defconfig
> * CONFIG_LOC: intree
> * DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
> * DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
> 
> Over time support will be added for all CIP supported architectures and
> configurations.
> 
> At the moment only simple boot tests are run. Real tests will be added in
> the future

Thanks, applied to 4.4-cip, and pushed out.
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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190711/a9151797/attachment.sig>
