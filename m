From: nobodyless@gmail.com (_nobody_ _nobody_)
Date: Wed, 24 Jan 2018 05:55:43 +0100
Subject: [cip-dev] Do we have bug in the Vagrantfile @
	https://gitlab.com/rajm/board-at-desk-single-dev/blob/master/Vagrantfile
In-Reply-To: <87372x2c88.fsf@ctlt579.codethink.co.uk>
References: <CABpTzB27SsjyWGXDS7tGZoS81=aRBZH1qpKgbP-CLjgrPrGbNg@mail.gmail.com>
	<87372x2c88.fsf@ctlt579.codethink.co.uk>
Message-ID: <CABpTzB3AEoUvari7n-144WNfOn5s2cQe8z3ajHHM+=8US7wZOw@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Copy that, Robert.

Please, to all: watch out for failing plugins, for both vagrant 1.9.8
and vagrant 2.0.1:
https://github.com/hashicorp/vagrant/issues/8948
https://github.com/hashicorp/vagrant/issues/9388
https://github.com/hashicorp/vagrant/issues/9396 <<== Zoran's issue

I have sorted out issues with Virtual Box: for Virtual Box I do not
see this problem (as they claim in #8948), and here I am using
advanced Virtual Box version 5.2.6 and Vagrant version 2.0.1.

I need to work on this Vagrant stabilization more... Most people are
using so far Virtual Box as provider.

Zoran Stojsavljevic

On Tue, Jan 23, 2018 at 9:47 AM, Robert Marshall
<robert.marshall@codethink.co.uk> wrote:
> _nobody_ _nobody_ <nobodyless@gmail.com> writes:
>
>> Hello to the list,
>>
>> This @ is insignificant, but we need to know if this is the typo in
>> the comment (seems like that, although for host it could be both 8080
>> or 80 values).
>>
>> File: https://gitlab.com/rajm/board-at-desk-single-dev/blob/master/Vagrantfile
>>
>> 43:  # Forward port 80 for the http Lava Frontend Web Server <<= PORT 80
>> 44:  config.vm.network :forwarded_port, guest: 8080, host: 8080
>>
>> Please, do note that I use my backup @, since I am (on my main
>> first.last at gmail.com) already on three Open Source mailing lists
>> (although I should say, traffic on this one is very low). ;-)
>>
>> Thank you,
>> Zoran Stojsavljevic
>
> Zoran
>
> Well spotted, I've added an issue for this so that it doesn't get lost!
> https://gitlab.com/cip-project/cip-testing/testing/issues/171
>
> Robert
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
