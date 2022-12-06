//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "PlaneStressTestApp.h"
#include "PlaneStressApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"
#include "ModulesApp.h"

InputParameters
PlaneStressTestApp::validParams()
{
  InputParameters params = PlaneStressApp::validParams();
  return params;
}

PlaneStressTestApp::PlaneStressTestApp(InputParameters parameters) : MooseApp(parameters)
{
  PlaneStressTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

PlaneStressTestApp::~PlaneStressTestApp() {}

void
PlaneStressTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  PlaneStressApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"PlaneStressTestApp"});
    Registry::registerActionsTo(af, {"PlaneStressTestApp"});
  }
}

void
PlaneStressTestApp::registerApps()
{
  registerApp(PlaneStressApp);
  registerApp(PlaneStressTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
PlaneStressTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  PlaneStressTestApp::registerAll(f, af, s);
}
extern "C" void
PlaneStressTestApp__registerApps()
{
  PlaneStressTestApp::registerApps();
}
