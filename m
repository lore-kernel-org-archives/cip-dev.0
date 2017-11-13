From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Mon, 13 Nov 2017 15:21:35 +0100
Subject: [cip-dev] CIP Testing Project: recap
Message-ID: <5A09AA6F.6040603@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

(this i a long mail)

As the below summary shows with more or less accuracy, the steps taken 
on the CIP Testing Project front has been:

1 Discuss the testing strategy. (completed)

2 Identify as initial need the availability of a testing framework that 
would allow us to test at least, the CIP kernel. Identify other steps to 
be taken. (completed)

3 Define the testing service architecture. (completed)

4 Work on the test environment according to the above requirements and 
strategy. (completed - ongoing). Action 1.

5 Release the test environment. (completed - ongoing).
    Action 1: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting#action-1board-at-desk-single-developer-b-d

6 Basic kernel testing (in progress).
    Action 2: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting#action-2cip-kernel-testing

7 Extend the number of technologies used to deploy B at D.
    Action 3: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting#action-3extend-the-number-of-technologies-used-to-deploy-b-d

8 From kernel testing to system testing.
    Action 4: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting#action-4from-kernel-testing-to-system-testing

9 Define kernel/system testing as a semi-distributed service within CIP.
    Action 5: 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting#action-5define-kernelsystem-testing-as-a-semi-distributed-service-within-cip

So point 6 (action 2) is where the CIP Testing project is today.

At ELCE 2017, based in several news and trends, and since the current 
service contract with Codethink was coming to an end, we all agreed that 
it was time to re-evaluate the current plan. As mentioned during today's 
TSC meeting, I will send a second e-mail with my views.

+ Historical view of the CIP Testing Project

A few months ago I did the following description that I now update and 
send to this list. The goal was back then, and now, to provide a 
historical overview of where are we in the CIP Testing Project. To do 
so, I have used the slides[1] from the different talks CIP has 
delivered, which are public.

++ July 2016 LinuxCon Japan[2]

* Slides 16 and 17 define the goals and plans. No specific mention to 
testing or how the kernel maintenance will be carried on
* Speakers: Yoshitake Kobayashi, Toshiba, Hiroshi Mine, Hitachi, Ltd. 
and Jan Kiszka, Siemens AG.

++ Aug 2016 LinuxCon North America[3]

* Slide 14 defines the Validation (testing) goals, defining as initial 
step of the testing project to set up the test infrastructure.
* Slide 17 describes the testing project steps in more detail. What 
later was called B at D is already mentioned, based on the goals previously 
set in slide 14.
* Jan from Siemens delivered the talk.

++ Oct 6th LinuxCon EU[4]

* No new content on the testing front was introduced in this event but 
the slides 14 and 17 of the deck used in August are described here 
again: slide 14 and 17.
* Talk delivered by Urs Gleim, Siemens AG, Corporate Technology & 
Yoshitake Kobayashi, Toshiba

++ Oct 2016 ELCE[5]

* Slide 30. The testing strategy figures as a milestone.
* Slide 23 replicates the strategy for kernel validation, which 
establishes that setting up the infrastructure is the first goal.
* Slide 24 develops those goals.
* Slide 25 shows the current steps. It even shows screenshots of the, by 
then, already functional solution.
* Slide 29 reflects the discussion points. You can see how the 
discussions point on the direction of future extensions of the already 
work in progress solution (KernelCI, with other solutions).
* The talk is delivered by Urs from Siemens and Yoshi from Toshiba.

++ Feb 2017 OSLS[6]

* Slide 18 describes the work in progress on the testing front
* Slide 20 defines the next steps to be taken in the CIP testing project.
* The talk was delivered by Noriaki Fukuyasu (Linux Foundation) and 
Agustin Benito Bethencourt (Codethink)

++ Feb 2017 ELC[7]

* Slide 17 defines the initial steps in the strategy towards validating 
the base layer (not the kernel alone). Again, it defines to create a 
test framework as initial step, like in the case of the kernel a year 
earlier.
* Slide 25 defines a more specific goals for CIP testing than before.
* Slide 26 provides an overview of the four key actions that the CIP 
testing project has defined.
* Slide 27 describes the status of the "test framework definition work" 
and the next steps.
* Slide 36 describes a little better some of the next steps planned 
related with the CIP testing project.

++ May 2017 OSSJ 2017[8]

* Slide 26 replicates the specific goals of the CIP testing project when 
it comes to the kernel.
* Slide 27 should be compared to slide 26 of the previous deck. It shows 
the progress on the CIP testing front.
* Slide 28 Reflects the release of CIP kernel testing framework called B at D.
* Slide 29 describes the next steps on the CIP kernel testing front.
* Slide 37 enumerates the key news from the project, being one of the 
the release of the kernel testing framework for the CIP kernel.
* Slide 39 describes the next steps to be taken.

++ October 2017 ELCE [9]

* Slide 34: enumerates the key actions of the CIP Testing Project plan.
* Slide 35: highlights of B at D v1.0 release.
* Slide 36: next steps of the CIP Testing project.
* The talk was delivered by Yoshi (Toshiba) and Urs (Siemens)

[1] 
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipconferences
[2] 
http://events.linuxfoundation.org/sites/events/files/slides/Intriducing_the_CIP-LCJ2016.pdf
[3] 
http://events.linuxfoundation.org/sites/events/files/slides/CIP-LinuxConNA.pdf
[4] 
https://wiki.linuxfoundation.org/_media/civilinfrastructureplatform/2016-10-06_cip-linuxconeu-r06.pdf
[5] 
https://wiki.linuxfoundation.org/_media/civilinfrastructureplatform/2016-10-06_cip-linuxconeu-r06.pdf
[6] https://wiki.linuxfoundation.org/_media/cip/osls2017_cip_v1_0.pdf
[7] 
http://events.linuxfoundation.jp/sites/events/files/slides/2017-02-22_CIP-ELC-r7.pdf
[8] 
http://events.linuxfoundation.org/sites/events/files/slides/2017-06-02_CIP-OSSJ-final_1.pdf
[9] 
http://events.linuxfoundation.org/sites/events/files/slides/2017-10-24_CIP-ELCE%20-%20v10.3.pdf

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
