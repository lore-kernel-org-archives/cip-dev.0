From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 6 Jun 2019 08:20:51 +0000
Subject: [cip-dev] gitlab-ci for CIP tiny profile (Deby)
In-Reply-To: <20190606065138.ggobgsedasddp2v2@demogorgon>
References: <TY2PR01MB332348D30D9AD1A6D62523E0D0170@TY2PR01MB3323.jpnprd01.prod.outlook.com>
	<20190606065138.ggobgsedasddp2v2@demogorgon>
Message-ID: <TY2PR01MB332360F60D512990800E9561D0170@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Continuing with this conversation on the public list, it seems that the job on gitlab-cloud-ci failed:
https://gitlab.com/cip-project/cip-core/deby/-/jobs/226291592

--- Error summary ---
ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
    Either fix the cause of this error or at your own risk disable the checker (see sanity.conf).
    Following is the list of potential problems / advisories:

    Do not use Bitbake as root

Perhaps it has something to do with privileged containers?

Thanks,
Daniel


> -----Original Message-----
> From: Adler, Michael <michael.adler@siemens.com>
> Sent: Thursday, June 6, 2019 3:52 PM
> To: sangorrin daniel(????? ???? ????????) <daniel.sangorrin@toshiba.co.jp>
> Cc: cip-dev at lists.cip-project.org
> Subject: Re: gitlab-ci for CIP tiny profile (Deby)
> 
> Hi Daniel,
> 
> > For that reason, I would like to register our Runner. Please let me know what should I do.
> 
> sure, no problem! I suggest moving my instance of the gitlab-ci runner to the project-level.
> Then it should be visible to all sub-projects (which includes your project).
> For this however, I would require the *runner registration token* of the parent project:
> 
> * Go to https://gitlab.com/cip-project, "Settings -> CI/CD"
> * Expand "Runners" section, copy&paste the token under "Set up a specific Runner manually"
> * Send me the token in in a pgp-encrypted mail (keyserver pgp.mit.edu, keyid: 0xf39a07eca4aabc19)
> 
> Best regards,
>   Michael
> 
> --
> Michael Adler
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany
> 
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme; Managing Board: Joe Kaeser,
> Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel,
> Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries:
> Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
