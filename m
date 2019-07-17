From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 17 Jul 2019 18:19:51 +0100
Subject: [cip-dev] [cip-kernel-sec][RESEND v3] report_affected: add
 support for reporting on tags
In-Reply-To: <20190711052624.8422-2-daniel.sangorrin@toshiba.co.jp>
References: <20190711052624.8422-1-daniel.sangorrin@toshiba.co.jp>
	<20190711052624.8422-2-daniel.sangorrin@toshiba.co.jp>
Message-ID: <a2db5f348e834b88a4b1c86c3129717efc321f07.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-07-11 at 14:26 +0900, Daniel Sangorrin wrote:
> Reporting on tags is useful for product engineers that
> have shipped a kernel with a specific tag and need to know
> which issues affect their product after some time.
> 
> Examples:
> $ ./scripts/report_affected.py v4.4 v4.4.107 v4.4.181-cip33
> $ cd ../kernel
> $ git tag myproduct-v1 0f13d9b4d0efa9e87381717c113df57718bc92d6
> $ cd ../cip-kernel-sec
> $ ./scripts/report_affected.py linux-4.19.y-cip:myproduct-v1 v4.19.50-cip3
[...]

Applied, thanks.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
