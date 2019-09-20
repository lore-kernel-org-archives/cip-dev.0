From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 20 Sep 2019 01:20:13 +0000
Subject: [cip-dev] [PATCH linux-4.19.y-cip] gitlab-ci: Always store
	job	artifacts
In-Reply-To: <20190918154250.8205-1-chris.paterson2@renesas.com>
References: <20190918154250.8205-1-chris.paterson2@renesas.com>
Message-ID: <OSAPR01MB32346C04331E80F4D5360AA392880@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chirs,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Chris
> Paterson
> Sent: Thursday, September 19, 2019 12:43 AM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] [PATCH linux-4.19.y-cip] gitlab-ci: Always store job
> artifacts
> 
> This means that we'll retain the Kernel configuration even if the build
> fails. Useful for debugging.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .gitlab-ci.yml | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)


> [linux-4.4.y-cip-rt,2/2] gitlab-ci: Run tests on RZ/G1C iwg23s platform 
> [linux-4.4.y-cip-rt,1/2] gitlab-ci: Always store job artifacts
> [linux-4.4.y-cip,2/2] gitlab-ci: Run tests on RZ/G1C iwg23s platform
> [linux-4.4.y-cip,1/2] gitlab-ci: Always store job artifacts
> [linux-4.19.y-cip-rt] gitlab-ci: Always store job artifacts

Applied, thanks.

Best regards,
  Nobuhiro
