function [ImaTabCentre] = visage_centre(ImaTab, Xmoy)
    for k=1:size(ImaTab,3)
      ImaTabCentre(:,:,k) = ImaTab(:,:,k) - Xmoy;
    end
end