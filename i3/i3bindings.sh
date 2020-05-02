#!/bin/bash



cat ~/.config/i3/config |grep bindsym >> ~/.config/i3/i3bindings.tmp
st -e less ~/.config/i3/i3bindings.tmp
rm ~/.config/i3/i3bindings.tmp



