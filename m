From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Wed, 5 Jul 2017 15:19:40 +0200
Subject: [cip-dev] LAVA health checks
Message-ID: <595CE76C.1040308@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

one of the tasks that the CIP testing team has been performing since 
before the B at D release is a daily LAVA health check using the CIP kernel 
and BBB[2].

What is a health check?

According to LAVA documentation[1]...

"A health check is a special type of test job, designed to validate that 
the a test device and the infrastructure around it are suitable for 
running LAVA tests. Health checks jobs are run periodically to check for 
equipment and/or infrastructure failures that may have happened. [...]"

So we are using this daily health check as "validation test" for B at D in 
our default (for now) set up, that is B at D running on Linux + CIP kernel 
+ BBB.

So on top of the testing that Ben H. does as maintainer, the CIP testing 
team is booting the kernel on the BBB using B at D on daily basis. On the 
positive side, this health check can be reproduced by others. But still 
we are providing limited value since results are not shared.

Action 2 is the next milestone, in which we want to use B at D to test the 
kernel (first, then a simple system) in a fully decentralised 
environment (some would call it architecture).

The initial step is for B at D to be able to send mails (reports) 
automatically to the cip-test-results mailing list. With this feature, 
we could collaborate in ensuring the B at D is ready to test the CIP kernel 
on complementary environments like:
* Using Renesas boards
* Running B at D on Windows10

on daily basis.

But sharing the results in the CIP context is far from enough. We need 
to ensure transparently that any of us is:
1. using the same tests...
2. to test the same CIP system...
3. on the same boards...
4. with the same tool set...
5. under the same environment...
6. producing the same reports...
7. based on the same logs.

During our Thursday meetings (remember they are open so please join us) 
we are starting to think about how we can use the health check concept 
to "validate" points 2 to 5. This is a very interesting challenge that 
we believe we can solve to great extend assuming a "fully distributed 
testing service architecture"..

[1] https://validation.linaro.org/static/docs/v2/healthchecks.html
[2] BBB - BeagleBone Black

Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
