From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Thu, 22 Feb 2018 15:58:32 +0100
Subject: [cip-dev] How to develop on the RT version
In-Reply-To: <SG2PR06MB11654A3FF485063C01FFC5C58ACD0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <SG2PR06MB1165F30CAFCC145F81AE021E8AF20@SG2PR06MB1165.apcprd06.prod.outlook.com>
	<001f01d3ab83$89b7b5a0$9d2720e0$@toshiba.co.jp>
	<SG2PR06MB11654A3FF485063C01FFC5C58ACD0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <4d0bdf7a-81db-ee4b-4846-cfdde236b201@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Chris,

On 22.02.2018 03:36, Chris Brandt wrote:
> On Wednesday, February 21, 2018, Daniel Sangorrin wrote:
>> The rebase branch is something complimentary, the maintainer may decide
>> not to prepare it (the same with the patches).
>> # The rebase branch might useful to see clearly which patches come from
>> the cip kernel and which ones are from PREEMPT RT.
> 
> OK, that was the info that I needed.

Sorry for the late response.

In short: linux-4.4.y-cip-rt wont be rebased. linux-4.4.y-cip-rt-rebase
tree contains the extracted patches from linux-4.4.y.cip-rt. Some people
like to get a patchset which they can apply on top of some tree. But it
looks no one here around is particular interested in this.

The linux-4.4.y-cip-patches is just a variation from the rebase branch.
Probably not really useful to anyone. I just archived all the a patches
in that branch. It was useful for me when I started with the scripting
to have a backup but I don't think I need it anymore. So if no one needs
I can drop it completely to avoid further confusion.

Thanks,
Daniel
