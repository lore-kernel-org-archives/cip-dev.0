From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Tue, 23 Jan 2018 08:47:19 +0000
Subject: [cip-dev] Do we have bug in the Vagrantfile @
	https://gitlab.com/rajm/board-at-desk-single-dev/blob/master/Vagrantfile
In-Reply-To: <CABpTzB27SsjyWGXDS7tGZoS81=aRBZH1qpKgbP-CLjgrPrGbNg@mail.gmail.com>
	(nobody nobody's message of "Mon, 22 Jan 2018 16:17:04 +0100")
References: <CABpTzB27SsjyWGXDS7tGZoS81=aRBZH1qpKgbP-CLjgrPrGbNg@mail.gmail.com>
Message-ID: <87372x2c88.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

_nobody_ _nobody_ <nobodyless@gmail.com> writes:

> Hello to the list,
>
> This @ is insignificant, but we need to know if this is the typo in
> the comment (seems like that, although for host it could be both 8080
> or 80 values).
>
> File: https://gitlab.com/rajm/board-at-desk-single-dev/blob/master/Vagrantfile
>
> 43:  # Forward port 80 for the http Lava Frontend Web Server <<= PORT 80
> 44:  config.vm.network :forwarded_port, guest: 8080, host: 8080
>
> Please, do note that I use my backup @, since I am (on my main
> first.last at gmail.com) already on three Open Source mailing lists
> (although I should say, traffic on this one is very low). ;-)
>
> Thank you,
> Zoran Stojsavljevic

Zoran

Well spotted, I've added an issue for this so that it doesn't get lost!
https://gitlab.com/cip-project/cip-testing/testing/issues/171

Robert
