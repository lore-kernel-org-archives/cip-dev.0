From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Mon, 27 Mar 2017 15:02:46 +0100
Subject: [cip-dev] Update 2017 wk12
Message-ID: <87mvc6n7g9.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear CIP friends,

here is the report of those tasks related with Testing and kernel
maintenance that we have been working on the past two weeks:

The whole team has been in Manchester for a week and has taken advantage
of that to have various face2face meetings.

CIP Testing

The following issues are being actively worked on:
* Issue #18 Exported vagrant box for an already loaded instance of CIP -
  the size of this instance has been reduced and a script is being
  prepared for the initial setup. (Issue #50)
* Issue #43 Refining test so that it uses the kernelci locally built kernel
* Issue #37 prepared checklist for release
* Issue #28 is still being investigated - to either document the
  requirement or alter the test script so if necessary it performs a
  'manual' login.
  

* Awaiting edit rights for Robert on the CIP public wiki

* Closed various solved issues
** #16 - Beaglebone black health check failing
** #22 - support arm64 build
** #33 - the VM requiring a weird mixture of debian versions
** #49 - deleted the VagrantFile sets up a USB passthru which is never used 
** #47 - document the possible timeouts on the QEMU test


CIP kernel maintenance

* Ben has the VM working under Debian stable

Remember you can:
* Download the beta version of Board at Desk - Single dev VM at the
CIP testing Download page:
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipdownload
* All issues/tickets referred in this report can be found in our
gitlab.com testing project:
https://gitlab.com/cip-project/testing/boards

Codethink has published a blog post related with CIP:
https://www.codethink.co.uk/blog/articles/2017/why-codethink-founding-member-civil-infrastructure-platform/

Best Regards

Robert
