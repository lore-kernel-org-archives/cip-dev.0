From: michael.adler@siemens.com (Adler, Michael)
Date: Thu, 6 Jun 2019 06:51:39 +0000
Subject: [cip-dev] gitlab-ci for CIP tiny profile (Deby)
In-Reply-To: <TY2PR01MB332348D30D9AD1A6D62523E0D0170@TY2PR01MB3323.jpnprd01.prod.outlook.com>
Message-ID: <20190606065138.ggobgsedasddp2v2@demogorgon>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

> For that reason, I would like to register our Runner. Please let me know what should I do.

sure, no problem! I suggest moving my instance of the gitlab-ci runner to the project-level.
Then it should be visible to all sub-projects (which includes your project).
For this however, I would require the *runner registration token* of the parent project:

* Go to https://gitlab.com/cip-project, "Settings -> CI/CD"
* Expand "Runners" section, copy&paste the token under "Set up a specific Runner manually"
* Send me the token in in a pgp-encrypted mail (keyserver pgp.mit.edu, keyid: 0xf39a07eca4aabc19)

Best regards,
  Michael

-- 
Michael Adler
Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme; Managing Board: Joe Kaeser, Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel, Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
