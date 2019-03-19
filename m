From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 19 Mar 2019 08:46:22 +0100
Subject: [cip-dev] CIP kernel Debian package
In-Reply-To: <OSAPR01MB37630D32D160DC2C7295C059D0400@OSAPR01MB3763.jpnprd01.prod.outlook.com>
References: <OSAPR01MB37630D32D160DC2C7295C059D0400@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <19f631ef-25f2-4492-51f2-0457437447ff@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 19.03.19 04:38, daniel.sangorrin at toshiba.co.jp wrote:
> Hello Jan,
> 
> When you build the kernel with ISAR, do you create a kernel Debian package?

Yes, but not in the form of the Debian distro kernel (which is not designed to 
be re-used for customizations). We rather use "make deb-pkg" from the upstream 
kernel, plus some post-build tunings to make the result a drop-in replacement of 
the distro package [1].

> 
> In that case, it would be interesting to distribute such kernel package separated from the rootfs. For example:
> - the package could be used with other build tools (e.g.: debos)
> - we could create a simple update mechanism for the kernel with apt-get
> - the kernel can be downloaded by LAVA for testing

Would be valid use cases.

> 
> Alternatively, we could setup a Gitlab CI environment to build the kernel and package it. Then, you would be able to install the kernel as a package in ISAR, instead of building it from scratch.
> 
> What do you think?

Both paths are possible. For building products, many users will add their own 
tunings and, thus, use the Isar recipe with custom configs. So, our recipes are 
important to be available in isar-cip-core, and that makes me lean slightly 
towards an Isar-generated kernel package. It should be easy to extend a ci 
script for the Isar build (which can be as simple as [2]) with an additional 
package update to a separate repo.

Jan

[1] 
https://github.com/ilbers/isar/blob/next/meta/recipes-kernel/linux/files/build-kernel.sh
[2] https://github.com/siemens/jailhouse-images/blob/master/.gitlab-ci.yml

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
