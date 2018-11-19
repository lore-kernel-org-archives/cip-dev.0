From: agustin.benito@codethink.co.uk (=?ISO-8859-1?Q?Agust=EDn?= Benito Bethencourt)
Date: Mon, 19 Nov 2018 17:24:52 +0000
Subject: [cip-dev] List of patches that failed to apply to 4.4-stable
In-Reply-To: <a43ce1ff-6183-437d-8666-9950e0af8c9b@siemens.com>
References: <002501d47a68$32e653d0$98b2fb70$@toshiba.co.jp>
	<2102685.09LOIKHG4k@linux-if6s>
	<a43ce1ff-6183-437d-8666-9950e0af8c9b@siemens.com>
Message-ID: <15907439.f7OZPu49ga@linux-if6s>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

On Monday, 19 November 2018 16:53:05 WET Daniel Wagner wrote:
> >> Yesterday, I checked the patches in my "failed to apply to 4.4-stable" list against the actual git repository using a short python script.
> >> It turns out that some of the patches in the "to apply" list were already there applied.
> >>
> >> I have updated our wiki page accordingly
> >> https://wiki.linuxfoundation.org/civilinfrastructureplatform/linux-4.4-failed-patches
> >>
> >> For the curious minds, you can find my (dirty) script attached to this e-mail.
> > 
> > If you can put the patches list as a repo on gitlab, and since the target repo is already being mirrored, I wonder if we can create a job that executes the script when the origin list gets updated. We can create a notification with the outcome to our testing mailing list. This way we just need to focus on having the origin in shape. If we add to this a way to parser the outcome in .md format and published as result in gitlab when the job "succeeds", we significantly reduce the effort associated to the wiki page.
> > 
> > @Daniel W. is the above possible, based on your experience with Gitlab?
> 
> I don't think you can update a .md file via gitlab-ci. Though there is
> GitLab pages which seems to be the thing for creating documentation via
> a CI/CD job:
> 
> https://docs.gitlab.com/ee/user/project/pages/

There are SSGs that digest .md

https://about.gitlab.com/2016/06/10/ssg-overview-gitlab-pages-part-2/

this way the report can also be visualized not just as a static page but also as a repo file, like a normal wiki page. In any case, the format of the report is not a key point. HTML alone would work fine too, I guess.

I assume you agree with the approach in general. Thanks for the response.

Best Regards
-- 
Agust?n Benito Bethencourt
Principal Consultant
Codethink Ltd
We respect your privacy.   See https://www.codethink.co.uk/privacy.html
