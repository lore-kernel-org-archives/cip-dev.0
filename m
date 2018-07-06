From: takuo.koguchi.sw@hitachi.com (=?utf-8?B?5bCP5Y+j55Ci5aSrIC8gS09HVUNISe+8jFRBS1VP?=)
Date: Fri, 6 Jul 2018 07:52:19 +0000
Subject: [cip-dev] Altera CIP branch vs. Denali NAND driver
In-Reply-To: <95cf4467-b48b-6a80-931c-a7f664048c6d@siemens.com>
References: <95cf4467-b48b-6a80-931c-a7f664048c6d@siemens.com>
Message-ID: <TYAPR01MB2160D07D4F9524CBF5A860D0D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

> at cip-playground to add denali support for an Arria 10 design here that
> uses 4.4-cip. However, it turned out that ECC is not working properly
> with that BSP driver. Are you aware of this?
Unfortunately I have been testing Denali NAND driver(with ECC enabled) only on two kinds of custom boards with cyclone5.
I had two problems using this driver;
(1) On one board, I need to add one to en_lo in function nand_onfi_timing_set before writing to RDWR_EN_LO_CNT.
 Without this, NAND was not detected.
(2) Bootloader needs to set SPARE_AREA_SKIP_BYTES properly, which is used by denali_hw_init. (I do not remember the actual value off the top of my head). Without this, it resulted in ECC errors as far as I remember.

Regarding to Denali Driver backport, "ignores other NAND drivers" is not a  good idea even for the playground, though I am not quite sure.

Takuo Koguchi


> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Friday, July 06, 2018 3:10 PM
> To: ???? / KOGUCHI?TAKUO <takuo.koguchi.sw@hitachi.com>
> Cc: Henning Schild <henning.schild@siemens.com>; cip-dev <cip-dev@lists.cip-project.org>
> Subject: [!]Altera CIP branch vs. Denali NAND driver
> 
> Hi Koguchi-san,
> 
> we have been using two commits [1][2] from the linux-cip-cyclonev branch
> at cip-playground to add denali support for an Arria 10 design here that
> uses 4.4-cip. However, it turned out that ECC is not working properly
> with that BSP driver. Are you aware of this?
> 
> Meanwhile I started the endeavor to backport the upstream denali driver
> to 4.4 which /seems/ to work (upstream definitely works) but is a >110
> commit long queue and ignores other NAND drivers. Lot's of mtd/nand
> subsystem changes unfortunately makes it unpalatable for cip upstream.
> But I wonder if there is common interest in a solution that is
> maintained - maybe in cip-playground - by more than a single product
> crew on our side.
> 
> Best regards,
> Jan
> 
> [1]
> https://clicktime.symantec.com/a/1/eB5fOHT2UDhywWydtoIvmvsHOebpJ2pbGUjuC-Me_xI=?d=jJWU0
> v6xiQhYCrKoK-hDT033fNX5TCId2Df2oX2qOuT3umPLKzKpWO8sqEBeh6VYCIZ2BNYZRnlpHXnwbYRzzXTi6aAT
> 2o0MRphqts7xqE-v8WvMPyYkVHS4m3QCV8jtyiqnw8NRgmuLMcSclezm8Y645ezRIONWT5kDX56AbwXFcYcWpq3
> EOtd8LVq_ZCyEKS37CW-NjcgxLadlLqAsKlQl-vlYt3ODGGSiFke5UauaA1AWeuTXBZ4yJD_bbGfNbsVfGGnmeg
> 07wv8im_P36lOy-SXkGM4wd3EKrxOutuyc28GPotTuA-7oThEY96mmXu_6ilgoGb0q4HKLbWOiX7ZzSNYBluHfz
> YUN1k3EjIN_6WfiYq5AXKb5aJhuRcdURbA%3D&u=https%3A%2F%2Fgitlab.com%2Fcip-playground%2Flin
> ux-cip-cyclonev%2Fcommit%2Fd6459dde24c46991b1976f780e74d02b9ebbed2e
> [2]
> https://clicktime.symantec.com/a/1/vuGtYXFhvkHicbAkms0pft_vrkR_th-16RSqIzH-lCw=?d=jJWU0
> v6xiQhYCrKoK-hDT033fNX5TCId2Df2oX2qOuT3umPLKzKpWO8sqEBeh6VYCIZ2BNYZRnlpHXnwbYRzzXTi6aAT
> 2o0MRphqts7xqE-v8WvMPyYkVHS4m3QCV8jtyiqnw8NRgmuLMcSclezm8Y645ezRIONWT5kDX56AbwXFcYcWpq3
> EOtd8LVq_ZCyEKS37CW-NjcgxLadlLqAsKlQl-vlYt3ODGGSiFke5UauaA1AWeuTXBZ4yJD_bbGfNbsVfGGnmeg
> 07wv8im_P36lOy-SXkGM4wd3EKrxOutuyc28GPotTuA-7oThEY96mmXu_6ilgoGb0q4HKLbWOiX7ZzSNYBluHfz
> YUN1k3EjIN_6WfiYq5AXKb5aJhuRcdURbA%3D&u=https%3A%2F%2Fgitlab.com%2Fcip-playground%2Flin
> ux-cip-cyclonev%2Fcommit%2Fc9bc5beb34d70efc11370cafb3f087657a80f112
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
