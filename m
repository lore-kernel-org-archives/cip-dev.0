From: wagi@monom.org (Daniel Wagner)
Date: Thu, 25 Jul 2019 10:37:38 +0200
Subject: [cip-dev] [RFC/RFT] -cip-rt kernels for review/testing
In-Reply-To: <20190723121535.GA11883@amd>
References: <20190623203704.GA12734@amd>
	<564b1c37-083e-5b56-7e56-abc4b9ddb7bd@siemens.com>
	<25cee49e-ea67-0e23-87b9-6198bd5749f4@monom.org>
	<20190723121535.GA11883@amd>
Message-ID: <87c7691e-49bc-df54-e9e9-312e81d3639e@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

>> The srt tool is available here: https://github.com/igaw/stable-rt-tools
>> It a few lines around git to make the steps consist. It is based on Steven
>> Rostedt workflow. Tom Zanussi (also -rt stable maintainer) and I am using
>> the tool to maintain the -rt trees.
> 
> Thanks for pointer. It does not want to run here (incompatible version
> of python 3?), so let me try to do one more manual attempt, and if
> that fails I'll try to fix/workaround python problems.

stable-rt-tools might depend on a newer version of Python3. I am running 
Python 3.7 here. I can't remember if there are any dependencies on newer 
version of Python3. What's the error message?

Thanks,
Daniel
