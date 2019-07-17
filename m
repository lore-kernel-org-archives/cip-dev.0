From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 17 Jul 2019 18:26:09 +0100
Subject: [cip-dev] [cip-kernel-sec][RESEND v2 2/2] report_affected: add
 show-description option
In-Reply-To: <20190711044425.30128-3-daniel.sangorrin@toshiba.co.jp>
References: <20190711044425.30128-1-daniel.sangorrin@toshiba.co.jp>
	<20190711044425.30128-3-daniel.sangorrin@toshiba.co.jp>
Message-ID: <4ff385ed23c8422bf21aecc1db625150409c67d9.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-07-11 at 13:44 +0900, Daniel Sangorrin wrote:
> Rather than looking up each issue file, I would like
> to have an overview of what each CVE ID means.
> 
> Example:
> $ ./scripts/report_affected.py --show-description linux-4.4.y-cip
[...]

I've applied this, but I think this feature could do with improvement.

Currently some descriptions are quite long, and may or may not include
line breaks, and that results in output that is hard to read.  The
importers should perhaps be changed to change line breaks into spaces,
but also this script should either truncate or word-wrap (and indent)
the descriptions.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
