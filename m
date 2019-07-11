From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 11 Jul 2019 14:26:23 +0900
Subject: [cip-dev] (Resend v3) move the tag with the other fields
Message-ID: <20190711052624.8422-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

I think this should be fine.
You need to remove the cached file import/stable_branches.yml

[cip-kernel-sec][RESEND v3] report_affected: add support for

To be honest, I am not 100% sure that the escape code is
perfectly correct. The file stable_branches.yml will have
parameters like this:

  tag_regexp: (^v3\.16$|^v3\.16\.\d+$)

Thanks,
Daniel
