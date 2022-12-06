#include "PlaneStressApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
PlaneStressApp::validParams()
{
  InputParameters params = MooseApp::validParams();

  return params;
}

PlaneStressApp::PlaneStressApp(InputParameters parameters) : MooseApp(parameters)
{
  PlaneStressApp::registerAll(_factory, _action_factory, _syntax);
}

PlaneStressApp::~PlaneStressApp() {}

void
PlaneStressApp::registerAll(Factory & f, ActionFactory & af, Syntax & syntax)
{
  ModulesApp::registerAll(f, af, syntax);
  Registry::registerObjectsTo(f, {"PlaneStressApp"});
  Registry::registerActionsTo(af, {"PlaneStressApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
PlaneStressApp::registerApps()
{
  registerApp(PlaneStressApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
PlaneStressApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  PlaneStressApp::registerAll(f, af, s);
}
extern "C" void
PlaneStressApp__registerApps()
{
  PlaneStressApp::registerApps();
}
