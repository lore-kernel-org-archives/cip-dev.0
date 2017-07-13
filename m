From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 13 Jul 2017 16:39:57 +0900
Subject: [cip-dev] Project-X (minimal root filesystem) : rewrite and
	renesas iwg20m board support
In-Reply-To: <12fda7a4-6602-1a30-9831-842274d58a65@siemens.com>
References: <006f01d2f6fe$264d6c60$72e84520$@toshiba.co.jp>
	<3a3fd45a-c550-07cc-5b34-de176818d1fd@siemens.com>
	<001f01d2f9d5$5de03250$19a096f0$@toshiba.co.jp>
	<71df6523-5844-01a2-8c67-d6ebc0a2a4f1@siemens.com>
	<001f01d2fa0f$ae4a6410$0adf2c30$@toshiba.co.jp>
	<f8e19682-8fcb-24dd-8567-0d28d9567571@siemens.com>
	<002001d2fa13$55b084c0$01118e40$@toshiba.co.jp>
	<cf2e5e11-508b-45b2-2e98-76a9287be45a@siemens.com>
	<001301d2fb6c$c541cfb0$4fc56f10$@toshiba.co.jp>
	<12fda7a4-6602-1a30-9831-842274d58a65@siemens.com>
Message-ID: <002a01d2fbab$409a2930$c1ce7b90$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> Sent: Thursday, July 13, 2017 3:37 PM
> To: Daniel Sangorrin; cip-dev at lists.cip-project.org
> Cc: 'kas-devel'
> Subject: Re: [cip-dev] Project-X (minimal root filesystem) : rewrite and renesas iwg20m board support
> 
> On 2017-07-13 02:12, Daniel Sangorrin wrote:
> > Hi Jan,
> >
> >> -----Original Message-----
> >> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> >> Sent: Wednesday, July 12, 2017 6:13 PM
> >> To: Daniel Sangorrin; cip-dev at lists.cip-project.org
> >> Cc: 'kas-devel'
> >> Subject: Re: [cip-dev] Project-X (minimal root filesystem) : rewrite and renesas iwg20m board support
> >>
> >> On 2017-07-11 09:00, Daniel Sangorrin wrote:
> >>>> -----Original Message-----
> >>>> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> >>>> Sent: Tuesday, July 11, 2017 3:42 PM
> >>>> To: Daniel Sangorrin; cip-dev at lists.cip-project.org
> >>>> Cc: 'kas-devel'
> >>>> Subject: Re: [cip-dev] Project-X (minimal root filesystem) : rewrite and renesas iwg20m board support
> >>>>
> >>>> On 2017-07-11 08:34, Daniel Sangorrin wrote:
> >>>>> Hi Jan,
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> >>>>>> Sent: Tuesday, July 11, 2017 3:20 PM
> >>>>>> To: Daniel Sangorrin; cip-dev at lists.cip-project.org
> >>>>>> Cc: kas-devel
> >>>>>> Subject: Re: [cip-dev] Project-X (minimal root filesystem) : rewrite and renesas iwg20m board support
> >>>>>>
> >>>>>> On 2017-07-11 01:36, Daniel Sangorrin wrote:
> >>>>>>>> Btw, instead of having yet another setup.sh, you may want to have a look
> >>>>>>>> at kas [2]. There is no release yet (next week, hopefully), but it is
> >>>>>>>> fairly mature. Moreover, you can build inside Docker, removing most of
> >>>>>>>> the host dependencies. We are using this now with both Yocto and Isar
> >>>>>>>> projects, often in layered ways [3] that enable reuse.
> >>>>>>>
> >>>>>>> Yesterday I managed to build the qemux86-64 meta layer using the following
> >>>>>>> kas project configuration. Could you check it please?
> >>>>>>>
> >>>>>>> https://gitlab.com/cip-playground/project-x/commit/de611ae06040f6e426d3c5d1b77eb20b4af31a19
> >>>>>>
> >>>>>> Looks good. You should just set version to 0.10 and use yesterday's
> >>>>>> release. You can pull the corresponding docker image from
> >>>>>> https://hub.docker.com/r/kasproject/, and there should be a pip package
> >>>>>> as well soon.
> >>>>>
> >>>>> That was fast. I was using the next branch and built the Dockerfile included in kas.
> >>>>>
> >>>>> I had to create a daemon.json to set overlay2 as the storage driver, pass the USER_ID variable,
> >>>>
> >>>> We should probably suggest to call "USER_ID=$(id -u) docker run ..." -
> >>>> it there a way to achieve this in an easier way? Still learning all this
> >>>> docker stuff.
> >>>
> >>> I was using the -e flag:
> >>>   docker run -e USER_ID=`id -u $USER` -it kas sh
> >>
> >> Err, right, that's what I meant.
> >>
> >>>
> >>>>> volume mount the project-x folder and manually set the proxy settings (for some reason using
> >>>>> build-args didn't work for me).
> >>>>
> >>>> Hmm, they should, I'm using them for builds all the time (along with
> >>>> corresponding settings for the docker daemon).
> >>>
> >>> Are you sure you didn't set them somewhere else in the docker configuration?
> >>> As far as I can see the Dockerfile is not using any ARG instruction at all.
> >>
> >> Yes, I'm sure. I've just written the doc for a product SDK, and that
> >> uses no further settings as well, see
> >> https://github.com/siemens/meta-iot2000/blob/jan/staging/README.md#docker-build.
> >
> > hmmm, I think that you made a small mistake in the kas documentation [1]. You wrote that
> > http_proxy should be passed as a build-arg but as I said there is no ARG instruction in the
> > Dockerfile.
> 
> No, also that works: It won't leave the proxy settings behind in the
> image, but it allows to build it behind a proxy.
> 
> We don't want to generate "proxified" images that will then only work in
> a very specific environment. We are coming from there, it was a mess.
> The image we have now can be fed into a CI build, and you only need to
> configure the specific proxies at project level. Works nicely with our
> corporate gitlab infrastructure.

OK, I understand your approach.

By the way ARG does not leave any settings behind (ENV does).
I was just confused because I thought that all available build-args had
to be declared on the Dockerfile through the ARG instruction. 

In the past, not doing so would throw an error. From the current docker 
documentation [1], it seems that that has changed and now it should 
only throw a warning:
  "If a user specifies a build argument that was not defined in the Dockerfile, 
  the build outputs a warning. [Warning] One or more build-args [foo] were not consumed."

Strange enough, I didn't see any warnings either. I wonder if the documentation
is outdated. 

In any case, the kas documentation does not mention anything about setting the
variables on "docker run" so it might be a good idea to provide the information 
form the meta-iot2000's README

If you are building from within a proxy-restricted network, make sure the settings are available via the standard environment variables and add

    -e http_proxy=$http_proxy -e https_proxy=$https_proxy \
    -e ftp_proxy=$ftp_proxy -e no_proxy=$no_proxy

Thanks,
Daniel 

[1] https://docs.docker.com/engine/reference/builder/#arg




Sorry I didn't know that you could use --build-arg
without defining an ARG instruction in the Dockerfile. It's not very clearly documented
on the docker website.

On the user's guide you mention "docker run -it kasproject/kas:<version> sh"

 or bind-mount the project into the container. See https://hub.docker.com/r/kasproject for all available images."
Still it might be helpful 

    -e http_proxy=$http_proxy -e https_proxy=$https_proxy \
    -e ftp_proxy=$ftp_proxy -e no_proxy=$no_proxy




> 
> Jan
> 
> >
> > In the meta-iot2000 link you are setting the proxy variables as environment variables using
> > 'docker run -e http_proxy=$http_proxy'  which does work indeed.>
> > [1] https://kas.readthedocs.io/en/latest/devguide.html
> >
> > Thanks,
> > Daniel
> >
> >
> >
> >
> 
> --
> Siemens AG, Corporate Technology, CT RDA ITP SES-DE
> Corporate Competence Center Embedded Linux
