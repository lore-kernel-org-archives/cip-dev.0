From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 12 Jul 2019 16:00:02 +0000
Subject: [cip-dev] [ANNOUNCE] Release 4.19.58-cip6 and 4.4.185-cip35
Message-ID: <OSBPR01MB4184CD943F3985A043132B3792F20@OSBPR01MB4184.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

CIP kernel team has released Linux kernel 4.19.58-cip6 and 4.4.185-cip35.

Linux-4.19.y-cip has been updated from base version from 4.19.56 to 4.19.58,
and linux-4.4.y-cip has been updated from 4.4.182 to 4.4.185 with pxa2xx's
spi fix.
And CIP's gitlab CI configuration file (.gitlab-ci.yml) has been added.

You can get this release via the git tree at:

  4.19.58-cip6:

    repository: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch: linux-4.19.y-cip
    commit: 2be2d3f02499e9d3a68f9e2ad1b1c4a0c42189b2
  
  4.4.185-cip35:

    This release has updated the base version from 4.4.182 to 4.4.185.

    repository: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch: linux-4.4.y-cip
    commit: 7b3d18ad0155a525f36903fc950dd27fe7ef1443

Best regards,
  Nobuhiro
