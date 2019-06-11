From: michael.adler@siemens.com (Adler, Michael)
Date: Tue, 11 Jun 2019 09:15:43 +0000
Subject: [cip-dev] gitlab-ci for CIP tiny profile (Deby)
In-Reply-To: <TY2PR01MB3323861584A80E70010AC415D0130@TY2PR01MB3323.jpnprd01.prod.outlook.com>
Message-ID: <20190611091542.3trij2we75iu7me6@demogorgon>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

I've done some experiments as well [1]. Could you try prefixing the "kas build" command with "gosu builder"?
Something like this:

gosu builder kas build --target core-image-minimal meta-cip-bbb/kas-bbb.yml

See also my gitlab-ci.yml [2].

Best regards,
  Michael

[1] https://gitlab.com/therisen06/entrypoint-debug/-/jobs/228882512
[2] https://gitlab.com/therisen06/entrypoint-debug/blob/3c1ffef93ca7880e11a984d4338bf04965962f1f/.gitlab-ci.yml

-- 
Michael Adler
Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme; Managing Board: Joe Kaeser, Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel, Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
