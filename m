From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Tue, 24 Jan 2017 17:58:19 +0100
Subject: [cip-dev] Y2038. a risk that requires attention today and would
 benefit from CIP participation
Message-ID: <588787AB.1050400@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

during the past CIP Members meeting call, Monday 23rd January, Members 
agreed on bringing to the attention of CIP contributors and friends the 
Y2038 topic.

What is Y2038 refers to?

"Y2038 refers to an issue related to the way time is handled by 
computers. Time is often represented as the number of seconds since Jan 
1, 1970. Whenever a 32-bit signed integer is used for this, the maximum 
value that can be represented is ? ~68 years, 19 days from the epoch, 
which corresponds to Jan 19, 2038. What happens after that is system 
dependent, but generally not good. A computer may act as if its time got 
reset to Dec 1901, or possibly to the epoch of Jan 1, 1970. It may give 
unexpected results or crash."

Definition extracted from http://www.y2038.com[1]. Check more about the 
description of the problem in Wikipedia[2].

The Linux Kernel community is already acting on this topic since version 
3.17[3] at least. One of the most interesting activities is to define 
tasks for newbies[4] related with this topic. You can read in this 
article[5] an update about what is being done, from 2015 and another 
reference[6] from 2016.

CIP Members has expressed their interest for Y2038 on user space too.

Arnd Bergmann, in CC, is one of the advocates of the Y2038 initiative.

@Arnd, is there any further documentation we should read about this 
topic? What are the key activities at this point within the Linux Kernel 
related with the topic? Who can we talk to related with user space? Any 
light you can provide us would be helpful.


[1] https://y2038.com/faq/
[2] https://en.wikipedia.org/wiki/Year_2038_problem
[3] https://lwn.net/Articles/607741/
[4] https://kernelnewbies.org/y2038
[5] https://lwn.net/Articles/643234/
[6] 
https://www.phoronix.com/scan.php?page=news_item&px=Linux-4.7-More-Y2038-Work

Best Regards
-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
