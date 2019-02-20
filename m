From: christian.storm@siemens.com (Christian Storm)
Date: Wed, 20 Feb 2019 15:49:34 +0100
Subject: [cip-dev] [swupdate] swupdate supporting binary delta caused an
	error
In-Reply-To: <OSAPR01MB2723989E295BC468A990FA56D97D0@OSAPR01MB2723.jpnprd01.prod.outlook.com>
Message-ID: <20190220144934.e2ivzbsdwgiabbb3@MD1ZFJVC.ad001.siemens.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Akihiro,

> I'm trying to use latest swupdate to use binary delta.
> I used 2 different size of files (10MiB and 50MiB) as update target,
> but their update results were different: 10MiB was success but 50MiB caused an error.
> 
> I suppose that the cause of the error is buffer related bug or perhaps
> my wrong test environment.
> Could you check following (or attached) details and give me some advice?
>
> [...]
>
>     [TRACE] : SWUPDATE running :  [apply_rdiff_chunk_cb] : rdiff chunk processing blocked for input, getting more chunk data.
>     [ERROR] : SWUPDATE failed [0] ERROR handlers/rdiff_handler.c : fill_inbuffer : 114 : Assertion violated: target - buffers->next_in <= RDIFF_BUFFER_SIZE.
>     double free or corruption (!prev)
>     Aborted (core dumped)
> 
>     ===> 50MiB target caused an error


First of all, thanks for the detailed report! It was of great help to
reproduce the issue locally. Your test environment is fine. Hence, what
you found is a bug.
The reason for this bug is that the librsync machinery gets the data
influxed by SWUpdate core feeding input data into it. Unlike the rdiff
tool that handles input by itself and hence has more knowledge and
control about it, the rdiff handler is just a consumer driven by the
SWUpdate core. As a result, it has to process any data the core gives to
it as there's no second chance to get the data even if the data cannot
be processed at that time instant. 
Your particular test specimen -- which I will for sure include in my
local set of test specimens -- triggers an input buffer fill that cannot
be processed (yet), so the choice is to either skip input data or
increase the buffer size. The former is not a good idea as there is no
second chance to process the data and hence the assertion. The latter
works but is no real fix to this issue as it's unclear (to me) what a
sensible buffer size would be. The reason you didn't run into this bug
with the 10M test specimen simply is that the buffer is large enough to
hold the data while with 50MB it's too small.
So, I'll think about a more aggressive input processing method and will
come back with a patch.

Thanks again for testing!


Kind regards,
   Christian

-- 
Dr. Christian Storm
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M?nchen, Germany
