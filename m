From: nobuhiro1.iwamatsu@toshiba.co.jp (Nobuhiro Iwamatsu)
Date: Fri, 17 May 2019 14:05:42 +0900
Subject: [cip-dev] [ANNOUNCE] 4.19.13-cip2 and 4.4.176-cip32
Message-ID: <20190517050542.y2fcv3r4it6wria2@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all

CIP kernel team has released Linux version Linux 4.19.13-cip2 and 4.4.176-cip32.
You can get this release via the git tree at:

  4.19.13-cip2:

    repository: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch: linux-4.19.y-cip
    commit: e096404446d7c1a0bf93efe11ebf7e25124e8642
  
  4.4.176-cip32:

    repository: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch: linux-4.4.y-cip
    commit: 02f6d022abba82455831e6463c12e38f47df8d61

And I introduce the updates for each kernel below.

About 4.19.13-cip2:
  This is the first 4.19 kernel with CIP's updates.
  The update adds support for RZ/G2E (R8A7774C0) on Renesas's ARM 64bit SoC
  and reference board (CAT874 and EK874).

About 4.4.176-cip32:
  This version adds DHCP fixes, and add support RZ/G1C (R8A77470) which is
  Renesas's ARM 32bit SoC and board support(iW-RainboW-G23S).

Best regards,
  Nobuhiro
