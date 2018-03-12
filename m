From: agustin.benito@codethink.co.uk (=?ISO-8859-1?Q?Agust=EDn?= Benito Bethencourt)
Date: Mon, 12 Mar 2018 10:09:43 +0100
Subject: [cip-dev] Codethink: report weeks 8 to 10
Message-ID: <4506707.ebAIXOiRZd@linux-if6s>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

## CIP kernel maintenance

* CIP Linux Kernel 4.4.120-cip20 released.
** Merge fixes from stable versions 4.4.113-4.4.120 inclusive
** Includes some mitigations for Spectre v1 and v2 on x86
** Fix stable regressions in x86/apic, arm/omap2, tca8418_keypad, leds
** Backport additional mitigations for Spectre on x86, and related   fixes
** Add SMP, I2C/IIC, RTC and SDHI support for R8A7743 and iWave board

## CIP kernel testing

* New fresh box provisioned. New CIP kernel tested with B at D. #149
** Link: https://gitlab.com/cip-project/cip-testing/testing/issues/149

* B at D update to latest kernelci version
** Branch works. Fixing last few reviews comments from Ben H.: https://
gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/merge_requests/53

* B at D on Renesas iw20gm. Work in progress. #166
** Ticket: https://gitlab.com/cip-project/cip-testing/testing/issues/166

* Private network usage for connection with board: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/merge_requests/55

## Other topics

* Codethink spotlight reviewed.

* Agustin at OSLS. 
** Lobbying towards LTS/LTSI/CIP?Debian alignment for the next kernel.
** It seems like the natural choice for all parties involved.

* Ben H. will attend to DebConf. 2018 sponsored by CIP.

Best Regards

-- 
Agust?n Benito Bethencourt
Principal Consultant
Codethink Ltd
