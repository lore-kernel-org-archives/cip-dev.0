From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Fri, 27 Oct 2017 14:57:08 +0200
Subject: [cip-dev] Status of cip-core
In-Reply-To: <003901d34be2$acfa4010$06eec030$@toshiba.co.jp>
References: <003901d34be2$acfa4010$06eec030$@toshiba.co.jp>
Message-ID: <b10de86c-b50e-33a0-fd74-826d7f4aaa86@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 10/23/2017 11:38 AM, Daniel Sangorrin wrote:
> Jan: what is KAS_WORK_DIR in http://kas.readthedocs.io/en/latest/userguide.html#environment-variables?

kas is designed so that you need to run it always from the same
directory you invoked it first. Basically the root folder for the
project. But if you like me, not always running kas from the same folder
KAS_WORK_DIR can be used to point to the root folder of the project.

Thanks,
Daniel
