From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 6 Jul 2018 08:09:31 +0200
Subject: [cip-dev] Altera CIP branch vs. Denali NAND driver
Message-ID: <95cf4467-b48b-6a80-931c-a7f664048c6d@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Koguchi-san,

we have been using two commits [1][2] from the linux-cip-cyclonev branch
at cip-playground to add denali support for an Arria 10 design here that
uses 4.4-cip. However, it turned out that ECC is not working properly
with that BSP driver. Are you aware of this?

Meanwhile I started the endeavor to backport the upstream denali driver
to 4.4 which /seems/ to work (upstream definitely works) but is a >110
commit long queue and ignores other NAND drivers. Lot's of mtd/nand
subsystem changes unfortunately makes it unpalatable for cip upstream.
But I wonder if there is common interest in a solution that is
maintained - maybe in cip-playground - by more than a single product
crew on our side.

Best regards,
Jan

[1]
https://gitlab.com/cip-playground/linux-cip-cyclonev/commit/d6459dde24c46991b1976f780e74d02b9ebbed2e
[2]
https://gitlab.com/cip-playground/linux-cip-cyclonev/commit/c9bc5beb34d70efc11370cafb3f087657a80f112

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
