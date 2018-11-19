From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Mon, 19 Nov 2018 17:53:05 +0100
Subject: [cip-dev] List of patches that failed to apply to 4.4-stable
In-Reply-To: <2102685.09LOIKHG4k@linux-if6s>
References: <002501d47a68$32e653d0$98b2fb70$@toshiba.co.jp>
	<CAFk6z8N7i2zQJhxSax3DNYPRg5piVMOzzbS9u=20hx5yY8z4vg@mail.gmail.com>
	<000901d47d73$eadf22b0$c09d6810$@toshiba.co.jp>
	<2102685.09LOIKHG4k@linux-if6s>
Message-ID: <a43ce1ff-6183-437d-8666-9950e0af8c9b@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

>> Yesterday, I checked the patches in my "failed to apply to 4.4-stable" list against the actual git repository using a short python script.
>> It turns out that some of the patches in the "to apply" list were already there applied.
>>
>> I have updated our wiki page accordingly
>> https://wiki.linuxfoundation.org/civilinfrastructureplatform/linux-4.4-failed-patches
>>
>> For the curious minds, you can find my (dirty) script attached to this e-mail.
> 
> If you can put the patches list as a repo on gitlab, and since the target repo is already being mirrored, I wonder if we can create a job that executes the script when the origin list gets updated. We can create a notification with the outcome to our testing mailing list. This way we just need to focus on having the origin in shape. If we add to this a way to parser the outcome in .md format and published as result in gitlab when the job "succeeds", we significantly reduce the effort associated to the wiki page.
> 
> @Daniel W. is the above possible, based on your experience with Gitlab?

I don't think you can update a .md file via gitlab-ci. Though there is
GitLab pages which seems to be the thing for creating documentation via
a CI/CD job:

https://docs.gitlab.com/ee/user/project/pages/
