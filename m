From: pavel@denx.de (Pavel Machek)
Date: Tue, 9 Apr 2019 22:54:46 +0200
Subject: [cip-dev] [PATCH 4.19.y 6/9] arm64: dts: renesas: r8a774c0: Add
 I2C and IIC-DVFS support
In-Reply-To: <1553688789-43441-7-git-send-email-biju.das@bp.renesas.com>
References: <1553688789-43441-1-git-send-email-biju.das@bp.renesas.com>
	<1553688789-43441-7-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20190409205446.GB3845141@pollux.denx.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed 2019-03-27 12:13:06, Biju Das wrote:
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> Add the I2C[0-7] and IIC Bus Interface for DVFS (IIC for DVFS)
> devices nodes to the r8a774c0 device tree.

This fails for me, because arch/arm64/boot/dts/renesas/r8a774c0.dtsi does not yet exist.

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
