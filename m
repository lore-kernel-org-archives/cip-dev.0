From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 8 Jan 2018 15:06:36 +0100
Subject: [cip-dev] [ANNOUNCE] Linux 4.4.15-cip15-rt10
In-Reply-To: <20180108105621.osnfazlumesxkwv3@linutronix.de>
References: <b4cf2728-0d0c-5128-d007-818e66da5613@siemens.com>
	<20180108093350.lxjocaxlvrmjwpav@linutronix.de>
	<94212c58-73c7-7356-b325-9e7f18c9bfbc@siemens.com>
	<20180108105621.osnfazlumesxkwv3@linutronix.de>
Message-ID: <66ceaf7a-1fd4-8902-ceac-42fff25fc646@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 2018-01-08 11:56, Sebastian Andrzej Siewior wrote:
> On 2018-01-08 11:13:12 [+0100], Daniel Wagner wrote:
>> Hi Sebastian,
> Hi Daniel,
> 
>> On 01/08/2018 10:33 AM, Sebastian Andrzej Siewior wrote:
>>> On 2018-01-02 12:56:11 [+0100], Daniel Wagner wrote:
>>>> The release is based on the Linux 4.4.75-rt88 version. That is I
>>>> applied the -rt88 patch on the 4.4.75-cip6 kernel and merged in all
>>>> CIP releases.
>>> what is cip6?
>>
>> CIP stands for Civil Infrastructure Platform [1]. Ben Hutchings maintains
>> the 4.4.x-cip kernel tree which is a super long stable tree [2].
> 
> So 4.4.x is maintained until Feb, 2022. I assumed that `cip' will take
> over / help Greg with the v4.4 tree and won't include its "own" things.

CIP includes a number of additional mainline backports (mostly around
SoC/board support and security), so it already deviates from vanilla
LTS. It's also aiming at a stricter QA than LTS.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
