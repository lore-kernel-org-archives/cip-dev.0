From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Sat, 28 Jul 2018 09:37:01 +0800
Subject: [cip-dev] How to add CVEs in cip-kernel-sec
In-Reply-To: <DFBF451ECD52064BBBA7B78676D4DA731A1F05BA@SIMTCSMB06.napa.ad.etn.com>
References: <DFBF451ECD52064BBBA7B78676D4DA731A1F05BA@SIMTCSMB06.napa.ad.etn.com>
Message-ID: <1532741821.21552.59.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2018-07-26 at 08:56 +0000, Kassabji, Christophe wrote:
> ?Hello,
> 
> I am new to this mailing list, so maybe you already discussed about
> this topic, but I couldn't find an archive to search so I post here.
> Please apologize if the topic is already discussed or if it is not
> the correct place to discuss this.
> If it is the case, please give me a place where I could post my
> questions.
> 
> We are planning to use the CIP kernel project for some of our
> products in order to benefit of the SLTS.
> In particular we are interested in using the cip-kernel-sec tool to
> track the CVEs which are backported to the linux-cip branch.
> AFAIU this tool needs an updated "issues" directory with a yml per
> CVE. These yml files are added by hand.

They can also be added using import_debian.py and import_ubuntu.py (and
potentially other importers).

> We have crossed the results of the import_stable.py script with the
> NIST database using the cve-search project.
> There are more than 100 CVEs missing in the yml files.
>
> So these are my questions:
> - is there a periodic plan for updating these yml files?

Not really.  You're the first person to express interest in it, so I
haven't been updating it regularly.

> - what are the criteria to add a new CVE in the issue directory?

I think any CVEs that affect an actively maintained branch should be
added.  Historical data is not important.

> - how can we contribute?

I would be happy to receive merge requests on Gitlab or by email.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
