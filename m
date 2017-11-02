From: binh.nguyen.uw@rvc.renesas.com (Binh Thanh. Nguyen)
Date: Thu, 2 Nov 2017 10:05:02 +0000
Subject: [cip-dev] B@D run on Renesas board - issue
Message-ID: <d06c1efd762e425b9fdbc5c263747828@RVC-EX13-M02.rvc.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel, Robert,

We are facing an issue when trying to run healthcheck using B at D on Renesas board.
I would like to attach the log and the healthcheck script (we modified the healthcheck from Daniel)

The boot action was passed, but after that, look like LAVA cannot send command to Board, only send "#" (it supposed to be "uname"). 
I wonder if you met same issue before? 
And if possible, please give us any hints you may have for debugging this issue!

Best regards,
Binh Nguyen


-------------- next part --------------
A non-text attachment was scrubbed...
Name: iwg20m-test-ramdisk.yaml
Type: application/octet-stream
Size: 1512 bytes
Desc: iwg20m-test-ramdisk.yaml
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20171102/33dd411c/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: logs.JPG
Type: image/jpeg
Size: 159978 bytes
Desc: logs.JPG
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20171102/33dd411c/attachment-0001.jpe>
