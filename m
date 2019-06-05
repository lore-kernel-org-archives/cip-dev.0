From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 5 Jun 2019 08:00:26 +0200
Subject: [cip-dev] porting iwg20m to isar-cip-core
In-Reply-To: <20190605021645.4464-1-daniel.sangorrin@toshiba.co.jp>
References: <20190605021645.4464-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <d0acd9f6-2f30-2407-c202-5600b3750352@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 05.06.19 04:16, Daniel Sangorrin wrote:
> I wanted to use uImage because that's what is used in the
> iwg20m manual, and it's known to work on Deby as well.
> Ref: https://gitlab.com/cip-project/cip-core/deby/blob/master/poky/meta-cip-iwg20m/README.IWG20M.txt
> Do you suggest that we should use bootz instead of bootm?
> Is uImage not recommended or something? I have used uImage in many boards.

BTW, we chose bootz (and distro boot) in order to be able to boot also stock 
Debian kernels - which work on a (slowly) increasing number of boards. I.e. Isar 
is modeled around the ideal case, not legacy ones.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
