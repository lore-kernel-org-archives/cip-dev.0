From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 14 Jun 2019 09:11:55 +0000
Subject: [cip-dev] [ANNOUNCE] 4.19.50-cip3 and 4.4.181-cip33
Message-ID: <OSBPR01MB418452DE0AB57E8B6792731192EE0@OSBPR01MB4184.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

CIP kernel team has released Linux kernel 4.19.50-cip3 and 4.4.181-cip33.
You can get this release via the git tree at:

  4.19.50-cip3:

    repository: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch: linux-4.19.y-cip
    commit: 0f13d9b4d0efa9e87381717c113df57718bc92d6
  
  4.4.181-cip33:

    repository: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch: linux-4.4.y-cip
    commit: b791a4823f245e7871dbdd05d8f13bcc5dc377c9

And I introduce the updates for each kernel below.

About 4.19.50-cip3:
  * This version has been updated from stable version 4.19.13 to 4.19.50, and
    many CVE fixes including MDS (Microarchitectural Data Sampling: CVE-2018-12130,
    CVE-2018-12126, CVE-2018-12127,, CVE-2019-11091).
  * CIP updates include device-tree fixes by Renesas.

About 4.4.176-cip32:
  * This version has been updated from stable version 4.4.176 to 4.4.181, and
    this also includes MDS fixes as in 4.19.y.
  * CIP updates include update of RZ/G1C by Renesas.

We plan to update the next CIP kernel on the fourth Friday.

Best regards,
  Nobuhiro
