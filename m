From: agustin.benito@codethink.co.uk (Agustin Benito Bethencourt)
Date: Tue, 17 Jan 2017 18:14:11 +0100
Subject: [cip-dev] kernelci setup fails
In-Reply-To: <bf0051c6-fa6f-3ed0-a578-b1cc5e9142bc@siemens.com>
References: <CANm2L4=-ZamtbxhvuY7wVRBja3P1YiL0cGkgVb_FPrFciFS3nA@mail.gmail.com>
	<bf0051c6-fa6f-3ed0-a578-b1cc5e9142bc@siemens.com>
Message-ID: <587E50E3.3080202@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On 17/01/17 17:32, Daniel Wagner wrote:
> Hi Don,
>
> On 01/17/2017 05:04 PM, Don Brown wrote:
>> I have the same problem and worked on it yesterday from several angles.
>> My notes are logged in Issue #12 in the GitLab repo. The link is:
>>
>> https://gitlab.com/cip-project/testing/issues/12
>
> I'll create a gitlab account soon, so that I can collaborate via the
> ticket system.

until then...

We have discussed what to do. There are several options:
1 Make Python 3.5.2 work on trusty.
2 Move on to Ubuntu 16.04
3 Move to an in-between version.
4 Try to move it into Debian so we can go for a single VM for the whole 
kernelci tolling.

Don is describing in the gitlab ticket his early tries of each option to 
determine which way to go. Although #4 is the desired one, it seems the 
most difficult one as well, so we decided to focus on the initial three.

We want to have the system working first and then we will figure out how 
we can simplify the deployment.

Best Regards

-- 
Agustin Benito Bethencourt
Principal Consultant - FOSS at Codethink
agustin.benito at codethink.co.uk
