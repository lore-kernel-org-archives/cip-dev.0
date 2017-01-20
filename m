From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Fri, 20 Jan 2017 10:34:15 +0100
Subject: [cip-dev] [PATCH] Use local copy of kernel-ci if present
In-Reply-To: <69aca7a7-5d83-190e-733f-85d0b57891b8@linux-kernel.net>
References: <20170119145744.6754-1-daniel.wagner@siemens.com>
	<69aca7a7-5d83-190e-733f-85d0b57891b8@linux-kernel.net>
Message-ID: <2a5ecb13-29c2-d80d-ffb4-b3459eb0e03d@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 01/19/2017 04:14 PM, Wolfgang Mauerer wrote:
> Am 19/01/2017 um 15:57 schrieb Daniel Wagner:
>> This is done by cloning all the remote repos to the project main
>> folder. This folder is shared with the VM. The intergration-scripts
>> are testing if those repos are in the shared folder than git clone
>> uses this as source.
> I've had to read the last sentence for a couple of times before
> I could make sense of it. Perhaps something along the lines of
> 
> 'The integration scripts test if the repos are present in the
> shared folder. They are used as source for "git clone" in this case.'

Good point. I lost myself in the depth of cloudy thoughts.
