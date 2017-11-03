From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Fri, 03 Nov 2017 16:04:58 +0000
Subject: [cip-dev] B@D run on Renesas board - issue
In-Reply-To: <d06c1efd762e425b9fdbc5c263747828@RVC-EX13-M02.rvc.renesas.com>
	(Binh Thanh. Nguyen's message of "Thu, 2 Nov 2017 10:05:02 +0000")
References: <d06c1efd762e425b9fdbc5c263747828@RVC-EX13-M02.rvc.renesas.com>
Message-ID: <87k1z7nyad.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

"Binh Thanh. Nguyen" <binh.nguyen.uw@rvc.renesas.com> writes:

> Hello Daniel, Robert,
>
> We are facing an issue when trying to run healthcheck using B at D on Renesas board.
> I would like to attach the log and the healthcheck script (we modified the healthcheck from Daniel)
>
> The boot action was passed, but after that, look like LAVA cannot send
> command to Board, only send "#" (it supposed to be "uname").
> I wonder if you met same issue before? 
> And if possible, please give us any hints you may have for debugging this issue!
>
> Best regards,
> Binh Nguyen

Thanh

Sorry for the delay in responding!

That test is missing a deploy section (all commented out) are you trying
to make the test too minimal? LAVA tends to swallow output if it is what
is expected.

Robert
