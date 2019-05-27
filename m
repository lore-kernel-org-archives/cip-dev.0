From: michael.adler@siemens.com (Adler, Michael)
Date: Mon, 27 May 2019 08:10:09 +0000
Subject: [cip-dev] [ANNOUNCE] Introducing gitlab-cloud-ci. Perform
 ISAR-based CI builds in the cloud.
In-Reply-To: <20190524143004.usdvezwd46ied6i4@xps.therub.org>
Message-ID: <20190527081008.oddoarkk4zmq6sef@demogorgon>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Dan,

> I thought they billed per-second now days, but looking into it, it seems that may only be for amazon linux and ubuntu
> AMIs?

you are right, it looks like they've changed it quite a while back [1] - at least for AMIs outside of the AWS
Marketplace, if I understood that part correctly.  Currently, I'm just using the kops default (Debian Jessie, with a 4.4
kernel), but Amazon Linux is supposed to work as well [2].

So yes, I think we can reduce the timeout value dramatically (maybe even down to 1 minute), possibly saving quite some
money over time. Thanks for the input, it's much appreciated!

> Do your builds take advantage of any caching, and if so, how are you making it persistent?

Caching is supported in general and up to the user (or rather their .gitlab-ci.yml [3]). IIRC, Gitlab Runner just
creates a zip file of the files/directories you've specified and uploads it to S3.

> I'm also really curious about your experience with k8s, but mostly I'm
> interested to find out how it works for this project over time in terms
> of stability, cost, complexity, etc.

Well, so am I :)

> Thanks again! If there is any place else I can follow information about
> this let me know.

For now, I can advise following the git repo and this mailing list. Code contributions are welcome as well, of course.

Best regards,
Michael

[1] https://aws.amazon.com/blogs/aws/new-per-second-billing-for-ec2-instances-and-ebs-volumes/
[2] https://github.com/kubernetes/kops/blob/release-1.11/docs/images.md
[3] https://docs.gitlab.com/ee/ci/caching/

-- 
Michael Adler
Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme; Managing Board: Joe Kaeser, Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel, Siegfried Russwurm, Ralf P. Thomas; Registered offices: Berlin and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322
