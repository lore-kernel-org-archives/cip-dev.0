From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Mon, 18 Dec 2017 12:36:21 +0100
Subject: [cip-dev] B@D: iwg20m support
In-Reply-To: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <8334d32c-edfb-76dd-3246-dca7cd9a9d62@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 12/14/2017 06:57 AM, Daniel Sangorrin wrote:
> Hi Trung-san, Robert and all
> 
> I received the AWS credentials from Agustin and uploaded
> the cip-core binaries for the Renesas iwg20m board.
> 
> https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/core-image-minimal-iwg20m.cpio.gz
> https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/r8a7743-iwg20d-q7.dtb
> https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/uImage

Just out of curiosity: how did you build the root fs? The naming
indicates that you used Yocto. I am still setting up my test environment
for rt testing and wrote two kas files to create me a root fs:

https://github.com/igaw/cip-rt-misc/blob/master/docs/kas-bbb.yml
https://github.com/igaw/cip-rt-misc/blob/master/docs/kas-minnowboard.yml

They are not self contained yet. Will fixed that right now. The idea
that you can write

	kas build kas-bbb.yml

and you get a root fs for testing.

Thanks,
Daniel
