From: michael.adler@siemens.com (Adler, Michael)
Date: Tue, 28 May 2019 14:20:05 +0000
Subject: [cip-dev] [ANNOUNCE] Introducing gitlab-cloud-ci. Perform
 ISAR-based CI builds in the cloud.
In-Reply-To: <20190524083711.wt6fg6atlixfbuux@demogorgon>
Message-ID: <20190528142004.hrvotkqqlus5gho7@demogorgon>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> Alright, we'll probably give it a try on Monday and see how it goes.

Today we performed the initial tests successfully [1]. It took 24 minutes to build the master branch, spending 3 minutes
waiting for the node (4 cores/16GB RAM/150GB NVMe SSD) to come up.

> Once you finish the initial test, we should be able to estimate the cost of using the cluster and probably ask the CIP board members to approve.

The base cost (no CI pipelines included) is $39.24 per month for the Kubernetes master node (t2.medium), which runs 24/7
and spins the slaves up and down, depending on the current workload situation.
The actual cost depends on the utilization (the number of CI pipelines triggered) and the configured node size. If we
take the node size from our example (m5d.xlarge), the AWS cost calculator [2] says:

* An average utilization of 2 hours/day (~4 builds) per month costs $16.60 per month

This scales linearly up and down, i.e. 4 hours/day per month would result in $33.20.  So in total you have the base cost
of $39.24 plus the node cost.  All numbers are for the region Frankfurt (just because it's my default, but you are free
to choose any region you like; e.g. North Virginia is only $13.79 instead of $16.60).

Best regards,
  Michael

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/pipelines/63516863
[2] https://calculator.s3.amazonaws.com/index.html

-- 
Michael Adler
Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme; Managing Board: Joe Kaeser, Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel, Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
